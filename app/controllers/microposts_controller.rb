class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create] #createの実行前だけApplicationControllerにあるlogged_in_userを実行してログインしていないユーザーは/loginにリダイレクトする
    
    def create
        @microposts = current_user.microposts.build(micropost_params)
        if @microposts.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            render "static_pages/home"
        end
    end
=begin
パラメータを受け取って現在のユーザーに紐付いたMicropostのインスタンスを作成して@micropost変数に入れ、@micropost.saveで保存が成功した場合は、
root_urlである/にリダイレクトを行い、失敗した場合はapp/views/static_pages/home.html.erbのテンプレートを表示します。
=end
    
    private
    def micropost_params
        params.require(:micropost).permit(:content)
    end
=begin
micropost_paramsでは、フォームから受け取ったパラメータのparams[:micropost]のうち、
params[:micropost][:content]のみデータの作成に使用するようにStrong Parametersを宣言しています。
コントローラでNote.new(params[:note])という書き方をしてしまうとどんな値でもセットできてしまうようになるのでセキュリティ上の問題がある。
そのため保存を許可するカラムを指定する「ストロングパラメータ」というものを使う。requireの引数にparamsのキー、permitの引数に保存を許可するカラムを指定する。 
そして、許可したカラムのみのハッシュを返すメソッドをprivateメソッドとして定義する。 
=end
end
