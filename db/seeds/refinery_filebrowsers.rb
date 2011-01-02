User.find(:all).each do |user|
  user.plugins.create(:name => "refinery_filebrowsers",
                      :position => (user.plugins.maximum(:position) || -1) +1)
end