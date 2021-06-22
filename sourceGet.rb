require 'open-uri'
class SourceGet
  def initialize(url)
    @source = URI.open(url).read
  end

  def get_slice(st_no, st_plus, st_wd, en_wd)
	  st = @source.index(/#{st_wd}/, st_no)
    return nil, 0 if st == nil
	  st += st_plus
    en = @source.index(/#{en_wd}/, st + 1)
    return @source.slice(st..en - 1), en
  end

  private
  def output
    @source
  end
end

# 使用例
# メジャーリーガーの成績を取得する場合、下記のようになります。

# 初期化時の引き数にソースコードを取得したいurlを指定
sg = SourceGet.new(%!https://baseball.yahoo.co.jp/mlb/japanese/!)

# get_sliceメソッドの引き数は、
# 左から順に検索開始文字位置、取得開始文字位置、取得開始文字列、取得終了文字列です
# ※取得開始文字位置は、開始文字列から何文字目よりスタートするかを指定します。

#大谷翔平の場合
ootani = sg.get_slice(0,0,"ロサンゼルス・エンゼルス","</tbody>")

# 戻り値は配列です。0番目:ソースコード、1番目:取得終了文字位置
puts ootani[0].gsub(/<[^>]*>/,'').gsub(/\n+/,"\n")# gsubでタグを削除しています。

#ダルビッシュ有の場合
darvish = sg.get_slice(0,0,"サンディエゴ・パドレス","</tbody>")
puts darvish[0].gsub(/<[^>]*>/,'').gsub(/\n+/,"\n")# gsubでタグを削除しています。
