class Admin::RefineryFilebrowsersController < Admin::BaseController

  crudify :refinery_filebrowser,
          :title_attribute => 'name'


end
