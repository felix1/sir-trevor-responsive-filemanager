# skip input[type=file]
SirTrevor.DEFAULTS.Block.upload_options.html = [
  '<div class="st-block__upload-container">',
    '<input class="st-upload-filename" type="hidden"/>'
    '<button class="st-upload-btn" type="button"><%= i18n.t("general:upload") %></button>',
  '</div>'].join '\n'

SirTrevor.DEFAULTS.Block.upload_options.filemanager =
  base_url: 'filemanager/dialog.php'
  width: '70%'
  height: '70%'
  maxWidth: 1000
  minHeight: 600
  maxHeigh: 900
  type: 'iframe'
  fitToView: false
  autoSize: false
  closeClick: false
  openEffect: 'none'
  closeEffect: 'none'
  padding: 8

_super = SirTrevor.BlockMixins.Uploadable.initializeUploadable
SirTrevor.BlockMixins.Uploadable.initializeUploadable = ->
  _super.apply this, arguments
  input_id = this.blockID + '-fileinput'
  this.$inputs.find('input.st-upload-filename').attr('id', input_id)
  this.$inputs.find('.st-upload-btn').on 'click', =>
    config = $.extend({}, this.upload_options.filemanager, {
      href: this.upload_options.filemanager.base_url + '?type=1&field_id='+input_id
      afterClose: =>
        this.$inputs.find('input.st-upload-filename').trigger('change')
    })
    $.fancybox config


SirTrevor.Blocks.Image.prototype.onBlockRender = ->
  this.$inputs.find('input').on 'change', (e) =>
    if (e.target.value)
      this.$editor.html($('<img>', src: e.target.value )).show()
      this.setData {
        file: { url: e.target.value }
      }