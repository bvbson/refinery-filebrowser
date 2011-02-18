module Refinery
  module RefineryFilebrowsers
    module Helper
      def skeller

        content_for :head do
          javascript_include_tag "selectbox.js"
        end

        randomiser = rand(Time.now.yesterday.to_i * Time.now.to_i)
        output = "<select size='5' id='refinery_filebrowser_select_#{randomiser}' name='refinery_filebrowser_select_#{randomiser}' multiple='multiple' style='width:250px;'></select>"

        output += javascript_tag "
      $(document).ready(function(){
        $('a[data-popup]').live('click', function(e) {
          browserWin=window.open($(this)[0].href, 'refinery_filebrowser_select', 'width=640,height=480,scrollbars=1,left=100,top=200, id=#{randomiser}');
          browserWin.focus();
          e.preventDefault();
        });
        $('a.refinery_up').click(function(e) {
          alert('up');
          Selectbox.moveOptionUp($('#refinery_filebrowser_select_#{randomiser}'));
          e.preventDefault();
        });
        $('a.refinery_down').click(function(e) {
          alert('down');
          Selectbox.moveOptionDown($('#refinery_filebrowser_select_#{randomiser}'));
          e.preventDefault();
        });
        $('a.refinery_delete').click(function(e) {
          alert('delete');
          e.preventDefault();
        });
      });
        "

        output += link_to(select_admin_refinery_filebrowsers_path(:id => randomiser ), :"data-popup" => true) do
          "Dateien auswählen"
        end
        output += link_to '#', :class => "refinery_up" do
          "Up"
        end
        output += link_to '#', :class => "refinery_down" do
          "Down"
        end
        output += link_to '#', :class => "refinery_delete" do
          "Delete"
        end

        output.html_safe
      end
    end
  end
end