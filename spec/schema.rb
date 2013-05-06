ActiveRecord::Schema.define :version => 0 do
  create_table "uploads", :force => true do |t|
    t.string :image_file_name
    t.string :image_content_type
    t.integer :image_updated_at
    t.integer :image_file_size
  end
end