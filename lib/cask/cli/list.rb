class Cask::CLI::List
  def self.run(*arguments)
    if arguments.any?
      list_files(*arguments)
    else
      list_installed
    end
  end

  def self.list_files(*cask_names)
    cask_names.each do |cask_name|
      begin
        cask = Cask.load(cask_name)
        if cask.installed?
          Cask::PrettyListing.new(cask).print
        else
          opoo "#{cask} is not installed"
        end
      rescue CaskError => e
        onoe e
      end
    end
  end

  def self.list_installed
    puts_columns Cask::CLI.nice_listing(Cask.installed)
  end

  def self.help
    "with no args, lists installed casks; given installed casks, lists installed files"
  end
end
