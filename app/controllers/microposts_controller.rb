class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create] #createの実行前だけApplicationControllerにあるlogged_in_userを実行してログインしていないユーザーは/loginにリダイレクトする
    
    def create
        @microposts = current_user.microposts.build(micropost_params) # current_user.microposts.buildはMicropost.new(user_id: current_user.id)と同じ
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
    
    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
=begin
current_userはログイン中のユーザー
user.micropostsはユーザーの全投稿なので、
current_user.micropostsはログイン中の、つまり自分の投稿全てを取得できます。
find_by という条件検索がついています。
なので、この結果からid がparams[:id]と一致するものを検索しています。
deleteボタンを押した際に、
micropost/:id
というURLが送信されてきますので、その;id部分から探し出し、削除しているという流れです。
=end
        return redirect_to root_url if @micropost.nil? #投稿が現在のユーザーのものでなければ、root_urlにリダイレクトする
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to request.referrer || root_url 
=begin
referrerとは、該当ページに遷移する直前に閲覧されていた参照元（遷移元・リンク元）ページのURL
redirect_to request.referrerがfalseがかnilの場合はroot_urlが実行される
=end
    end
    
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
