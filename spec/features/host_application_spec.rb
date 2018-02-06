# frozen_string_literal: true

shared_examples 'a Rails 5.1 application' do
  it 'should require a rails 5.1.* gem' do
    expect(gems[:rails]).to start_with('5.1')
  end

  it 'should require a rails-ujs module', js: true do
    [source_page_path, target_page_path].each do |path|
      visit path
      page.execute_script('if (window.Rails) { document.body.innerHTML = "Rails-ujs included" }')
      expect(page).to have_text('Rails-ujs included')
    end
  end
end

shared_examples 'any application' do
  let(:source_page_text) { 'This is a source page' }
  let(:target_page_text) { 'This is a target page' }

  describe 'should have a source page' do
    before { visit source_page_path }

    it 'should contain a source page text' do
      expect(page).to have_text(source_page_text)
    end

    it 'should not contain a target page text' do
      expect(page).not_to have_text(target_page_text)
    end

    it 'should have no div tag' do
      expect(page).not_to have_css('div')
    end

    it 'should have a .without-confirm anchor' do
      anchor = nil
      expect(page).to have_css('a.without-confirm', count: 1) { |a| anchor = a }
      expect(anchor[:href]).to eq(target_page_path)
      expect(anchor[:'data-confirm']).to be_nil
    end

    it 'should have a .with-confirm anchor' do
      anchor = nil
      expect(page).to have_css('a.with-confirm', count: 1) { |a| anchor = a }
      expect(anchor[:href]).to eq(target_page_path)
      expect(anchor[:'data-confirm']).to eq('Confirmation text')
    end

    it 'should have a .with-customized-confirm anchor' do
      anchor = nil
      expect(page).to have_css('a.with-customized-confirm', count: 1) { |a| anchor = a }
      expect(anchor[:href]).to eq(target_page_path)
      expect(anchor[:'data-confirm']).to eq('Confirmation text')
      expect(anchor[:'data-confirm-title']).to eq('Title text')
      expect(anchor[:'data-confirm-yes']).to eq('Yes text')
      expect(anchor[:'data-confirm-no']).to eq('No text')
      expect(anchor[:'data-confirm-close']).to eq('Close text')
    end

    it 'should include maac javascript', js: true do
      page.execute_script('document.body.innerHTML = "Maac version: " + window.Maac.version')
      expect(page).to have_text("Maac version: #{Maac::VERSION}")
    end
  end

  describe 'should have a target page' do
    before { visit target_page_path }

    it 'should not contain a source page text' do
      expect(page).not_to have_text(source_page_text)
    end

    it 'should contain a target page text' do
      expect(page).to have_text(target_page_text)
    end

    it 'should have no div tag' do
      expect(page).not_to have_css('div')
    end

    it 'should include maac javascript', js: true do
      page.execute_script('document.body.innerHTML = "Maac version: " + window.Maac.version')
      expect(page).to have_text("Maac version: #{Maac::VERSION}")
    end
  end

  it 'should require a local maac gem' do
    require File.expand_path('../../../lib/maac/version', __FILE__)
    expect(gems[:maac]).to eq(Maac::VERSION)
  end
end

shared_examples 'a Bootstrap v3 application', js: true do
  it 'should require a Bootstrap v3 gem' do
    expect(gems[:'bootstrap-sass']).to start_with('3.3.')
  end

  it 'should include a jQuery' do
    visit source_page_path
    page.execute_script('if (window.jQuery) { document.body.innerHTML = "jQuery defined" }')
    expect(page).to have_text('jQuery defined')
  end

  it 'should include a Bootstrap.modal' do
    visit source_page_path
    page.execute_script('if ($.fn.modal) { document.body.innerHTML = "Bootstrap.modal defined" }')
    expect(page).to have_text('Bootstrap.modal defined')
  end
end

shared_examples 'a Bootstrap v4 application' do
  it 'should require a Bootstrap v4 gem'
end

shared_examples 'a Vanilla JS application', js: true do
  it 'should not include a jQuery' do
    visit source_page_path
    page.execute_script('if (!window.jQuery) { document.body.innerHTML = "No jQuery defined" }')
    expect(page).to have_text('No jQuery defined')
  end
end

describe 'Host application', type: :feature do
  let(:application_gems) do
    visit root_path
    JSON.parse(page.text, symbolize_names: true)
  end

  context 'which is based on Rails 5.1', rails51: true do
    it_should_behave_like 'any application' do
      let(:gems) { application_gems }
    end

    it_should_behave_like 'a Rails 5.1 application' do
      let(:gems) { application_gems }
    end
  end

  context 'which uses a Bootstrap v3', bs3: true do
    it_should_behave_like 'a Bootstrap v3 application' do
      let(:gems) { application_gems }
    end
  end

  context 'which uses a Bootstrap v4', bs4: true do
    it_should_behave_like 'a Bootstrap v4 application' do
      let(:gems) { application_gems }
    end
  end

  context 'which uses a Vanilla JS', vanillajs: true do
    it_should_behave_like 'a Vanilla JS application' do
      let(:gems) { application_gems }
    end
  end
end
