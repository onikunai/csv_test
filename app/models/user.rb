class User < ApplicationRecord
  def self.import(file)
    i = 0
    p "ファイル名"
    p file.original_filename
    CSV.foreach(file.path, encoding: "SJIS:UTF-8") do |row_ary_csv|
      p i
      row_ary = []
      row_ary_csv.each { |row_ary_bef|
        # row_ary_bef.gsub!(',', '&#44;')

        # 実行する処理1
        # p row_ary_bef

        row_ary.push(row_ary_bef)
      }
      p row_ary
      row_hedder = ["name", "age"]
      ary = [row_hedder,row_ary].transpose
      row = Hash[*ary.flatten]
      p row
      
      user = User.new
      user.attributes = row.to_hash.slice(*updatable_attributes)
      user.save
      i += 1
      # ファイル名の取得
      filename_csv = File.basename(file.original_filename, '.*')
      p "ここからファイル名"
      p filename_csv
    end
    # # row = {"id":"5" "name":"asd" "age":"20"}
    # hash = {"id" => "5", "name" => "kaki", "age" => "12,30"}
    # # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
    # user = find_by(id: hash["id"]) || new
    # # CSVからデータを取得し、設定する
    # user.attributes = hash.to_hash.slice(*updatable_attributes)
    # # 保存する
    # user.save
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name", "age"]
  end
end
