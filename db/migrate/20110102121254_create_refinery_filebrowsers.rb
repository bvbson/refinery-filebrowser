class CreateRefineryFilebrowsers < ActiveRecord::Migration

  def self.up
    create_table :refinery_filebrowsers do |t|
      t.string  :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :position

      t.timestamps
    end

    add_index :refinery_filebrowsers, :id

    load(Rails.root.join('db', 'seeds', 'refinery_filebrowsers.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "refinery filebrowsers"})

    Page.delete_all({:link_url => "/refinery_filebrowsers"})

    drop_table :refinery_filebrowsers
  end

end
