# frozen_string_literal: true

shared_examples 'a closing clickable' do
  it 'should remain on a source page' do
    button.click
    expect(page).to have_text(source_page_text)
  end

  context 'when a before_remove uses provided callback' do
    before do
      page.execute_script('window.Maac.before_remove = function (cb) { document.body.innerHTML += "before_remove called"; cb(); }')
      button.click
    end

    it 'should call a window.Maac.before_remove' do
      expect(page).to have_text('before_remove called')
    end

    it 'should remove a modal code' do
      expect(page).not_to have_css(Maac.selector)
    end
  end

  context 'when a before_remove does not use provided callback' do
    before do
      page.execute_script('window.Maac.before_remove = function () { document.body.innerHTML += "before_remove called" }')
      button.click
    end

    it 'should call a window.Maac.before_remove' do
      expect(page).to have_text('before_remove called')
    end

    it 'should not remove a modal code' do
      expect(page).to have_css(Maac.selector)
    end
  end
end

shared_examples 'a confirming clickable' do
  context 'when a before_remove uses provided callback' do
    before do
      page.execute_script('window.Maac.before_remove = function (cb) { cb(); }')
      button.click
    end

    it 'should redirect to a target page' do
      expect(page).to have_text(target_page_text)
    end
  end

  context 'when a before_remove does not use provided callback' do
    before do
      page.execute_script('window.Maac.before_remove = function () { document.body.innerHTML += "before_remove called" }')
      button.click
    end

    it 'should call a window.Maac.before_remove' do
      expect(page).to have_text('before_remove called')
    end

    it 'should not remove a modal code' do
      expect(page).to have_css(Maac.selector)
    end

    it 'should remain on a source page' do
      expect(page).to have_text(source_page_text)
    end
  end
end

describe 'Client code', type: :feature, substantive: true, js: true do
  let(:source_page_text) { 'This is a source page' }
  let(:target_page_text) { 'This is a target page' }

  before { visit source_page_path }

  it 'should assign Maac::VERSION to window.Maac.version' do
    page.execute_script('document.body.innerHTML = JSON.stringify(window.Maac.version)')
    expect(page).to have_text(Maac::VERSION)
  end

  it 'should assign Maac.strings to window.Maac.strings' do
    page.execute_script('document.body.innerHTML = JSON.stringify(window.Maac.strings)')
    expect(page).to have_text(Maac.strings.to_json)
  end

  it 'should assign Maac.template to window.Maac.template' do
    page.execute_script('document.body.innerText = window.Maac.template')
    expect(page).to have_text(Maac.template)
  end

  it 'should assign Maac.after_append to window.Maac.after_append' do
    page.execute_script('document.body.innerHTML = window.Maac.after_append')
    expect(page).to have_text(Maac.after_append)
  end

  it 'should assign Maac.before_remove to window.Maac.before_remove' do
    page.execute_script('document.body.innerHTML = window.Maac.before_remove')
    expect(page).to have_text(Maac.before_remove)
  end

  it 'should assign Maac.selector to window.Maac.selector' do
    page.execute_script('document.body.innerHTML = window.Maac.selector')
    expect(page).to have_text(Maac.selector)
  end

  it 'should assign Maac.selector_y to window.Maac.selector_y' do
    page.execute_script('document.body.innerHTML = window.Maac.selector_y')
    expect(page).to have_text(Maac.selector_y)
  end

  it 'should assign Maac.selector_n to window.Maac.selector_n' do
    page.execute_script('document.body.innerHTML = window.Maac.selector_n')
    expect(page).to have_text(Maac.selector_n)
  end

  it 'should contain no template code' do
    expect(page).not_to have_css(Maac.selector)
  end

  context 'after clicking on a confirm-less link' do
    before { find('.without-confirm').click }

    it 'should redirect to target page' do
      expect(page).to have_text(target_page_text)
    end
  end

  context 'after clicking on a link with confirmation' do
    let(:link) { find('.with-confirm') }

    before { page.execute_script('window.confirm = function () { document.body.innerHTML += "Confirm called"; return false; }') }

    it 'should not redirect to target page' do
      link.click
      expect(page).to have_text(source_page_text)
    end

    it 'should not populate a standard confirm dialog' do
      link.click
      expect(page).not_to have_text('Confirm called')
    end

    it 'should append a window.Maac.template code to a page' do
      page.execute_script('window.Maac.template = "Template code goes here"')
      link.click
      expect(page).to have_text('Template code goes here')
    end

    it 'should call a window.Maac.after_append' do
      page.execute_script('window.Maac.after_append = function () { document.body.innerHTML += "after_append called" }')
      link.click
      expect(page).to have_text('after_append called')
    end

    it 'should translate strings in a template' do
      page.execute_script('window.Maac.strings = { aaa: "A first string", bbb: "A second string" }')
      page.execute_script('window.Maac.template = "BEGIN %{aaa} %{bbb} END"')
      link.click
      expect(page).to have_text('BEGIN A first string A second string END')
    end

    it 'should not append more than one modal' do
      page.execute_script('window.Maac.after_append = function () { document.body.innerHTML += "after_append called" }')
      10.times { link.click }
      expect(page).to have_text('after_append called', count: 1)
    end

    describe 'a No button is available' do
      it_behaves_like 'a closing clickable' do
        let(:button) { find('#js-maac-no') }
        before { link.click }
      end
    end

    describe 'a Close button is available' do
      it_behaves_like 'a closing clickable' do
        let(:button) { find('#js-maac-close') }
        before { link.click }
      end
    end

    describe 'a Yes button is available' do
      it_behaves_like 'a confirming clickable' do
        let(:button) { find('#js-maac-yes') }
        before { link.click }
      end
    end

    describe 'a confirm message is available' do
      before do
        page.execute_script('document.querySelector(".with-confirm").setAttribute("data-confirm", "A confirmation message")')
        link.click
      end

      it 'should render a value of a data-confirm attribute' do
        expect(page).to have_css(Maac.selector, text: 'A confirmation message')
      end
    end
  end

  context 'after clicking on a link with a customized confirmation' do
    before { link.click }
    let(:link) { find('.with-customized-confirm') }

    it 'should display a provided data-confirm-title text' do
      expect(page).to have_css(Maac.selector, text: 'Title text')
    end

    it 'should display a provided data-confirm-yes text' do
      expect(page).to have_css(Maac.selector, text: 'Yes text')
    end

    it 'should display a provided data-confirm-no text' do
      expect(page).to have_css(Maac.selector, text: 'No text')
    end
  end
end
