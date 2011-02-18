class CreateAlbums < ActiveRecord::Migration

  def self.up
    create_table :albums do |t|
      t.string :name
      t.string :cover
      t.integer :position

      t.timestamps
    end

    add_index :albums, :id

    load(Rails.root.join('db', 'seeds', 'albums.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "Albums"})

    Page.delete_all({:link_url => "/albums"})

    drop_table :albums
  end

end
