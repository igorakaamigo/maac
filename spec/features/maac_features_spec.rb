require_relative '../spec_helper'

feature 'A confirm() replacement', type: :feature do
  given(:source_page_text) { 'This is a source page' }
  given(:target_page_text) { 'This is a target page' }
  given(:confirmation_text) { 'a correct confirmation text' }

  given(:confirmation_title) { 'Localized title' }
  given(:confirmation_yes) { 'Localized yes' }
  given(:confirmation_no) { 'Localized no' }
  given(:confirmation_close) { 'Localized close' }

  context 'with given prerequisites' do
    context 'when a source page' do
      before { visit source_page_path }

      it 'should have a source page text' do
        expect(page).to have_text(source_page_text)
      end

      it 'should not have a target page text' do
        expect(page).not_to have_text(target_page_text)
      end

      it 'should have an a.without-confirm without data-confirm attribute' do
        expect(page).to have_css("a.without-data-confirm[href='#{target_page_path}']:not([data-confirm])", count: 1)
      end

      it 'should have an a.with-confirm with data-confirm="a correct confirmation text" attribute' do
        expect(page).to have_css("a.with-data-confirm[href='#{target_page_path}'][data-confirm='#{confirmation_text}']", count: 1)
      end

      it 'should have an a.with-customized-confirm with data-confirm="a correct confirmation text" and data-cpnfirm-* attributes' do
        link = nil
        expect(page).to have_css("a.with-customized-confirm[href='#{target_page_path}'][data-confirm='#{confirmation_text}']", count: 1) { |a| link = a }
        expect(link['data-confirm-title']).to eq(confirmation_title)
        expect(link['data-confirm-yes']).to eq(confirmation_yes)
        expect(link['data-confirm-no']).to eq(confirmation_no)
        expect(link['data-confirm-close']).to eq(confirmation_close)
      end

      it 'should not have any modal code' do
        expect(page).not_to have_css('.modal', visible: :any)
      end
    end

    context 'when a target page' do
      before { visit target_page_path }

      it 'should have a target page text' do
        expect(page).to have_text(target_page_text)
      end

      it 'should not have a source page text' do
        expect(page).not_to have_text(source_page_text)
      end
    end
  end

  context 'while being on a source page' do
    before { visit source_page_path }

    context 'clicking on a confirm-less link' do
      before { click_link class: 'without-data-confirm' }

      it 'should redirect to target page' do
        expect(page).to have_text(target_page_text)
      end
    end

    context 'clicking on a link with a data-confirm attribute', js: true do
      before { click_link class: 'with-data-confirm' }

      it 'should not redirect to target page' do
        expect(page).not_to have_text(target_page_text)
      end

      context 'should append the modal code to a pages body which should have' do
        given(:text_for_title) { 'Confirm' }
        given(:text_for_yes) { 'Yes' }
        given(:text_for_no) { 'No' }
        given(:modal_selector) { 'div.modal[tabindex="-1"][role="dialog"]' }

        scenario 'a valid layout' do
          expect(page).to have_css(modal_selector, count: 1)
        end

        scenario 'a valid header' do
          header_selector = "#{modal_selector} > .modal-dialog > .modal-content > .modal-header"
          expect(page).to have_css("#{header_selector} > h5.modal-title", count: 1, text: text_for_title)
          expect(page).to have_css("#{header_selector} > button.close[type=button][aria-label='Close']", count: 1)
        end

        scenario 'a valid body' do
          body_selector = "#{modal_selector} > .modal-dialog > .modal-content >.modal-body"
          expect(page).to have_css("#{body_selector} > p", count: 1, text: confirmation_text)
        end

        scenario 'a valid footer' do
          footer_selector = "#{modal_selector} > .modal-dialog > .modal-content > .modal-footer"
          expect(page).to have_css("#{footer_selector} > button.btn.btn-secondary[type=button]", count: 1, text: text_for_yes)
          expect(page).to have_css("#{footer_selector} > button.btn.btn-primary[type=button]", count: 1, text: text_for_no)
        end
      end

      it 'should call a $(".modal").modal()'
    end

    context 'clicking on a link with a data-confirm attribute and customizations', js: true do
      before { click_link class: 'with-customized-confirm' }

      it 'should not redirect to target page' do
        expect(page).not_to have_text(target_page_text)
      end

      context 'should append the modal code to a pages body which should have' do
        given(:text_for_title) { confirmation_title }
        given(:text_for_yes) { confirmation_yes }
        given(:text_for_no) { confirmation_no }
        given(:text_for_close) { confirmation_close }
        given(:modal_selector) { 'div.modal[tabindex="-1"][role="dialog"]' }

        scenario 'a valid layout' do
          expect(page).to have_css(modal_selector, count: 1)
        end

        scenario 'a valid header' do
          header_selector = "#{modal_selector} > .modal-dialog > .modal-content > .modal-header"
          expect(page).to have_css("#{header_selector} > h5.modal-title", count: 1, text: text_for_title)
          expect(page).to have_css("#{header_selector} > button.close[type=button][aria-label='#{confirmation_close}']", count: 1)
        end

        scenario 'a valid body' do
          body_selector = "#{modal_selector} > .modal-dialog > .modal-content >.modal-body"
          expect(page).to have_css("#{body_selector} > p", count: 1, text: confirmation_text)
        end

        scenario 'a valid footer' do
          footer_selector = "#{modal_selector} > .modal-dialog > .modal-content > .modal-footer"
          expect(page).to have_css("#{footer_selector} > button.btn.btn-secondary[type=button]", count: 1, text: text_for_yes)
          expect(page).to have_css("#{footer_selector} > button.btn.btn-primary[type=button]", count: 1, text: text_for_no)
        end
      end

      it 'should call a $(".modal").modal()'
    end

    context 'while modal is shown', js: true do
      before { click_link class: 'with-data-confirm' }

      context 'after pressing a Close button' do
        before { click_button class: 'close' }

        it 'should not have any modal code' do
          expect(page).not_to have_css('.modal', visible: :any)
        end

        it 'should not have a target page text' do
          expect(page).not_to have_text(target_page_text)
        end

        it 'should call a $(".modal").modal("hide")'
      end

      context 'after pressing a No button' do
        before { click_button class: 'btn-primary' }

        it 'should not have any modal code' do
          expect(page).not_to have_css('.modal', visible: :any)
        end

        it 'should not have a target page text' do
          expect(page).not_to have_text(target_page_text)
        end

        it 'should call a $(".modal").modal("hide")'
      end

      context 'after pressing a Yes button' do
        before { click_button class: 'btn-secondary' }

        it 'should have a target page text' do
          expect(page).to have_text(target_page_text)
        end

        it 'should call a $(".modal").modal("hide")'
      end
    end
  end
end
