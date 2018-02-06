# frozen_string_literal: true

describe Maac::Config, bs3: true do
  describe '@template' do
    it 'should have a default value' do
      expect(subject.template).to eq(File.new(File.expand_path('../../../tpl/bs3.html', __FILE__)).read)
    end
  end

  describe '@selector' do
    it 'should have a default value' do
      expect(subject.selector).to eq('.maac-popup')
    end
  end

  describe '@selector_y' do
    it 'should have a default value' do
      expect(subject.selector_y).to eq('#js-maac-yes')
    end
  end

  describe '@selector_n' do
    it 'should have a default value' do
      expect(subject.selector_n).to eq('#js-maac-no,#js-maac-close')
    end
  end

  describe '@after_append' do
    it 'should have a default value' do
      expect(subject.after_append).to eq('function () { $(".maac-popup").modal({"backdrop": "static"}); }')
    end
  end

  describe '@before_remove' do
    it 'should have a default value' do
      expect(subject.before_remove).to eq('function (cb) { $(".maac-popup").modal("hide"); cb(); }')
    end
  end
end

describe Maac::Config, vanillajs: true do
  describe '@template' do
    it 'should have a default value' do
      expect(subject.template).to eq(File.new(File.expand_path('../../../tpl/vanilla.html', __FILE__)).read)
    end
  end

  describe '@selector' do
    it 'should have a default value' do
      expect(subject.selector).to eq('.maac-popup')
    end
  end

  describe '@selector_y' do
    it 'should have a default value' do
      expect(subject.selector_y).to eq('#js-maac-yes')
    end
  end

  describe '@selector_n' do
    it 'should have a default value' do
      expect(subject.selector_n).to eq('#js-maac-no,#js-maac-close')
    end
  end

  describe '@after_append' do
    it 'should have a default value' do
      expect(subject.after_append).to eq('function () { /* After append */; }')
    end
  end

  describe '@before_remove' do
    it 'should have a default value' do
      expect(subject.before_remove).to eq('function (cb) { /* Before remove */; cb(); }')
    end
  end
end

describe Maac::Config, substantive: true do
  describe '#OPTIONS' do
    it 'should be an array' do
      expect(subject.class::OPTIONS).to be_instance_of(Array)
    end
  end

  describe '@strings' do
    it 'should be included to OPTIONS' do
      expect(subject.class::OPTIONS).to include(:strings)
    end

    it 'should have a default value' do
      expected = {
        title: 'Confirm',
        yes:   'Yes',
        no:    'No',
        close: 'Close'
      }
      expect(subject.strings).to eq(expected)
    end
  end

  describe '@template' do
    it 'should be included to OPTIONS' do
      expect(subject.class::OPTIONS).to include(:template)
    end
  end

  describe '@selector' do
    it 'should be included to OPTIONS' do
      expect(subject.class::OPTIONS).to include(:selector)
    end
  end

  describe '@selector_y' do
    it 'should be included to OPTIONS' do
      expect(subject.class::OPTIONS).to include(:selector_y)
    end
  end

  describe '@selector_n' do
    it 'should be included to OPTIONS' do
      expect(subject.class::OPTIONS).to include(:selector_n)
    end
  end

  describe '@after_append' do
    it 'should be included to OPTIONS' do
      expect(subject.class::OPTIONS).to include(:after_append)
    end
  end

  describe '@before_remove' do
    it 'should be included to OPTIONS' do
      expect(subject.class::OPTIONS).to include(:before_remove)
    end
  end
end
