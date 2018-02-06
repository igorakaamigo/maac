# frozen_string_literal: true

describe Maac, type: :feature, substantive: true do
  describe '#configure' do
    it 'should yield with configuration' do
      config = nil
      Maac.configure { |c| config = c }
      expect(config).to be_instance_of Maac::Config
    end

    it 'should yield with the same config object' do
      configs = []
      2.times { Maac.configure { |c| configs << c } }
      expect(configs.first).to be(configs.last)
    end

    context 'while set all allowed options' do
      before do
        Maac.configure do |c|
          Maac::Config::OPTIONS.each do |key|
            c.send("#{key}=", "value_for_#{key}".to_sym)
          end
        end
      end

      it 'should delegate all readers to Maac::Config' do
        Maac::Config::OPTIONS.each do |key|
          expect(Maac.send(key)).to eq("value_for_#{key}".to_sym)
        end
      end

      it 'should delegate all writers to Maac::Config' do
        Maac::Config::OPTIONS.each do |key|
          value = "current_value_for_#{key}".to_sym
          Maac.send("#{key}=", value)
          expect(Maac.send(key)).to eq(value)
        end
      end
    end
  end
end
