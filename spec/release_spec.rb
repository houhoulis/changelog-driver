require 'rspec'
require 'pry'
require_relative '../lib/changelog_parser'

describe Release do
  let(:release) { Release.new }

  context '#sections' do
    it 'will only return sections that have content in them' do
      release.added = ['things']
      release.changed = ['yooo']

      expect(release.sections).to match_array(['added', 'changed'])
    end

    it 'will return an empty array if no sections have content' do
      expect(release.sections).to eq([])
    end
  end

  context '#add' do
    context 'will add an item' do
      it 'to a section if its a string' do
        string = 'string to add'
        release.add('added', string)

        expect(release.added).to match_array([string])
      end

      it 'to a section if its an array' do
        array = [1,2,3]
        release.add('added', array)

        expect(release.added).to match_array(array)
      end

      it 'to a section that already has things in it' do
        release.added = [1,2]
        release.add('added', [2,3])

        expect(release.added).to match_array([1,2,3])
      end
    end

    context 'will not add an item' do
      it 'if it has already been added' do
        string = "String"
        release.add('added', string)

        expect(release.added).to match_array([string])
        release.add('added', string)

        expect(release.added).to match_array([string])
      end
    end
  end
end
