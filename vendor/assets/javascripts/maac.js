
/*!
Modal As A Confirm (MAAC) v1.0.1 (2018-02-02T21:36:12+03:00)
https://github.com/igorakaamigo/maac
Released under the MIT license:
https://github.com/igorakaamigo/maac/blob/master/MIT-LICENSE
 */

(function() {
  var safeBsModal, showAModal;

  Rails.delegate(document, 'a[data-confirm]', 'confirm', function(event) {
    showAModal(this, 'Yes', 'No', 'Close', 'Confirm');
    return false;
  });

  safeBsModal = function(arg) {
    if (this.jQuery && this.jQuery.fn.modal) {
      return this.jQuery('.modal').modal(arg);
    }
  };

  showAModal = function(link, defaultYes, defaultNo, defaultClose, defaultTitle) {
    var close, dialogClose, dialogNo, dialogTitle, dialogYes, modal;
    modal = document.createElement('div');
    modal.className = 'modal';
    modal.setAttribute('tabindex', '-1');
    modal.setAttribute('role', 'dialog');
    dialogYes = link.getAttribute('data-confirm-yes') || defaultYes;
    dialogNo = link.getAttribute('data-confirm-no') || defaultNo;
    dialogClose = link.getAttribute('data-confirm-close') || defaultClose;
    dialogTitle = link.getAttribute('data-confirm-title') || defaultTitle;
    modal.innerHTML = '<div class="modal-dialog" role="document"> <div class="modal-content"> <div class="modal-header"> <h5 class="modal-title"></h5> <button type="button" class="close" aria-label=""> <span aria-hidden="true">&times;</span> </button> </div> <div class="modal-body"> <p></p> </div> <div class="modal-footer"> <button type="button" class="btn btn-secondary"></button> <button type="button" class="btn btn-primary"></button> </div> </div> </div>';
    modal.querySelector('.modal-body > p').innerText = link.getAttribute('data-confirm');
    modal.querySelector('.modal-footer > .btn-secondary').innerText = dialogYes;
    modal.querySelector('.modal-footer > .btn-primary').innerText = dialogNo;
    modal.querySelector('.modal-header > button').setAttribute('aria-label', dialogClose);
    modal.querySelector('.modal-header > h5').innerText = dialogTitle;
    close = function() {
      Rails.stopEverything(event);
      safeBsModal('hide');
      return modal.remove();
    };
    Rails.delegate(modal, '.close,.btn-primary', 'click', close);
    Rails.delegate(document, '.modal-backdrop', 'click', close);
    Rails.delegate(modal, '.btn-secondary', 'click', function(event) {
      close();
      link.removeAttribute('data-confirm');
      return Rails.fire(link, 'click');
    });
    document.body.appendChild(modal);
    return safeBsModal();
  };

}).call(this);
