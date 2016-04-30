class Changelog
  attr_accessor :releases

  def initialize
    @releases = []
  end

  def unreleased
    releases.detect { |r| /[Uu]nreleased/ =~ r.title }
  end

  def released
    releases - [unreleased]
  end

  def sorted_releases
    [unreleased] | released.sort_by { |r|
      /\A\[(?<version>.+)\] - (?<date>.+)/ =~ r.title

      # sort by version, but in worst case scenario, include date sorting
      version.split('.').map(&:to_i) | [date.split('-')]
    }.reverse
  end

  def add_release(release)
    if r = find_release(release.title)
      release.sections.each do |section|
         r.add(section, release.get(section))
      end
    else
      releases << release
    end
  end

  private
  def find_release(title)
    releases.detect { |r| r.title == title }
  end
end
