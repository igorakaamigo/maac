###!
Modal As A Confirm (MAAC) {VERSION} ({DATE})
https://github.com/igorakaamigo/maac
Released under the MIT license:
https://github.com/igorakaamigo/maac/blob/master/MIT-LICENSE
###

Rails.delegate document, 'a[data-confirm]', 'confirm', (event) ->
  showAModal(this, 'Yes', 'No', 'Close', 'Confirm')
  false

safeBsModal = (arg) ->
  if @jQuery and @jQuery.fn.modal
    @jQuery('.modal').modal(arg)

showAModal = (link, defaultYes, defaultNo, defaultClose, defaultTitle) ->
  modal = document.createElement('div')
  modal.className = 'modal'
  modal.setAttribute('tabindex', '-1')
  modal.setAttribute('role', 'dialog')

  dialogYes = link.getAttribute('data-confirm-yes') || defaultYes;
  dialogNo = link.getAttribute('data-confirm-no') || defaultNo;
  dialogClose = link.getAttribute('data-confirm-close') || defaultClose;
  dialogTitle = link.getAttribute('data-confirm-title') || defaultTitle;

  modal.innerHTML =
    '<div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title"></h5>
          <button type="button" class="close" aria-label="">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary"></button>
          <button type="button" class="btn btn-primary"></button>
        </div>
      </div>
    </div>'
  modal.querySelector('.modal-body > p').innerText = link.getAttribute('data-confirm')
  modal.querySelector('.modal-footer > .btn-secondary').innerText = dialogYes
  modal.querySelector('.modal-footer > .btn-primary').innerText = dialogNo
  modal.querySelector('.modal-header > button').setAttribute('aria-label', dialogClose)
  modal.querySelector('.modal-header > h5').innerText = dialogTitle

  close = ->
    Rails.stopEverything(event)
    safeBsModal('hide')
    modal.remove()

  Rails.delegate modal, '.close,.btn-primary', 'click', close
  Rails.delegate document, '.modal-backdrop', 'click', close

  Rails.delegate modal, '.btn-secondary', 'click', (event) ->
    close()
    link.removeAttribute('data-confirm')
    Rails.fire link, 'click'

  document.body.appendChild(modal)
  safeBsModal()
