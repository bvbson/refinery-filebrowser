require 'pathname'

class FileBrowserDataStore < Dragonfly::DataStorage::FileDataStore

      def store(temp_object)

      end

      def retrieve(path)
        File.new(path)
      end

      def destroy(uid)

      end

end