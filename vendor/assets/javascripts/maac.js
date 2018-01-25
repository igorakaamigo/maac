(function() {
  var showAModal;

  Rails.delegate(document, 'a[data-confirm]', 'confirm', function(event) {
    var confirm, link;
    link = this;
    if (link.hasAttribute('data-confirmed')) {
      link.removeAttribute('data-confirmed');
      confirm = function() {
        return true;
      };
      return true;
    }
    showAModal(link, 'Yes', 'No', 'Close', 'Confirm');
    return false;
  });

  showAModal = function(link, defaultYes, defaultNo, defaultClose, defaultTitle) {
    var dialogClose, dialogNo, dialogTitle, dialogYes, modal;
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
    Rails.delegate(modal, '.close,.btn-primary', 'click', function(event) {
      Rails.stopEverything(event);
      return modal.remove();
    });
    Rails.delegate(modal, '.btn-secondary', 'click', function(event) {
      Rails.stopEverything(event);
      modal.remove();
      link.setAttribute('data-confirmed', true);
      return Rails.fire(link, 'click');
    });
    return document.body.appendChild(modal);
  };

}).call(this);
