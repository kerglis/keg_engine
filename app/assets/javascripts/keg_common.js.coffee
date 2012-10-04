Array::diff = (a) ->
  @filter (i) ->
    not (a.indexOf(i) > -1)

fixHelper = (e, ui) ->
  ui.children().each ->
    $(this).width $(this).width()
    $(this).children().each ->
      $(this).width $(this).width()
  $(ui).closest("table").find("th").each ->
    $(this).width $(this).width()
  ui

$.fn.convert_remote_links = ->
  $("[remote-links]").find("a").each ->
    $(this).attr("data-remote", "true") unless $(this).attr("href") is "#"

$.fn.bind_modal_data_url = ->
  $("[data-url]").each ->
    $(this).load_modal_data_url()

$.fn.load_modal_data_url = ->
  $(this).bind "click", ->
    el_id = "#" + $(this).data("controls-modal") + " .in_body"
    $(el_id).html ""
    $.ajax
      url: $(this).data("url")
      complete: (jqXHR) ->
        $(el_id).spin false
        $(el_id).html jqXHR.responseText

$.fn.concat_checkbox_text = ->
  $str = ""
  $(this).find("input[type='checkbox']:checked").each ->
    $str +=  "<span class='btn btn-mini'>" + $(this).parent().text() + "</span> "
  $str

$.fn.bind_collapsible_label = ->
  $switch = $($(this).data("collapsible-label"))
  $main_el = $($(this).data("collapsible-main"))
  $opt_el = $($(this).data("collapsible-opt"))

  $switch.addClass("switch")
  $main_el.hide()
  $opt_el.show()

  $switch.on
    click: ->
      $(this).toggleClass("open")
      if $(this).hasClass("open")
        $main_el.show()
        $opt_el.hide()
      else
        $main_el.hide()
        $opt_el.show()

$.fn.bind_checkboxes_clone = ->
  $el = $($(this).data("checkboxes-clone"))
  $new_id = $(this).data("checkboxes-clone-into")

  $str = $el.concat_checkbox_text()
  $new_el = $("<div class='controls' id='#{$new_id}' style='margin-top: 5px;'></div>").hide()
  $new_el.html($str)

  $new_el.insertBefore($el)

  $el.find("input[type='checkbox']").on
    click: ->
      $str = $el.concat_checkbox_text()
      $new_el.html($str)

$.fn.bind_boolean_value = ->
  $(this).on
    click: ->
      $(this).parent().find("a").removeClass("active")
      $hidden = $(this).parent().next("input[type='hidden']")

      $val = $(this).data("boolean-value")
      $hid_val = $hidden.val()

      if ("#{$val}" != "#{$hid_val}")
        $hidden.val($val)
        $(this).addClass("active")
      else
        $hidden.val("")

      $("form").submit()

$.fn.bind_switches = ->
  $(".switch").each ->
    $(this).bind "click", ->
      el = $("#" + $(this).data("switchable"))
      if $(this).hasClass("open")
        $(this).removeClass "open"
        $(this).addClass "closed"
        el.hide()
      else
        $(this).removeClass "closed"
        $(this).addClass "open"
        el.show()

$.fn.bind_clearable_fields = ->
  $("[data-clearable-field]").each ->
    input = $(this)
    form = (if input.length > 0 then $(input[0].form) else $())
    link = $("<a href=\"#\" class=\"active_field_clear\">x</a>")
    $(this).after link
    input.bind "change", ->
      form.submit()

    link.bind "click", ->
      input.val ""
      form.submit()

$.fn.bind_filter_html_elements = ->
  $("[data-filter-html]").on "keyUp", ->
    q = $(this).val()
    src_tag = $(this).data("src-tag")
    dest_tag = $(this).data("dest-tag")
    src_class = $(this).data("src-class")

    reg = new RegExp(".*" + q, "i")
    els = $("#{src_tag}.#{src_class}")
    els.each ->
      str = $(this).html()
      id = "#" + $(this).attr("id").replace(src_tag + "_", dest_tag + "_")
      unless q is ""
        if str.match(reg)
          $(id).show()
        else
          $(id).hide()
      else
        $(id).show()

$.fn.bind_button_urls = ->
  $("[data-button-url]").on "click", ->
    window.location = $(this).data("button-url")
    false

$.fn.bind_counter = ->
  $data = $(this).data()
  if $data
    $data.timerEnd = ->
      if $data.timerend
        $f = $data.timerend
      else
        $f = ""
      eval $f
      false

    $data.startTime = $data.starttime
    $data.digitWidth = $data.digitwidth
    $data.digitHeight = $data.digitheight

    $(this).countdown($data)

$.fn.bind_bluecloth =  ->
  $id = $(this).attr("id") + "_bluecloth"
  $(this).after $("<div/>").attr("id", $id).addClass("well bluecloth-preview pull-right")
  $prev_el = $(this).next()
  $prev_el.formatize $(this)
  $(this).bind "keyup", ->
    $prev_el.formatize $(this)

$.fn.formatize = (src) ->
  el = $(this)
  $.ajax
    url: "/formatizer"
    data:
      text: src.val()
    success: (data) ->
      el.html data.text

$.fn.remove_fields = (link) ->
  $(link).prev("input[type=hidden]").val "1"
  $(link).closest(".fields").hide(400)

$.fn.add_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")

  $new_html = content.replace(regexp, new_id)

  if ($(link).data("parent-selector"))
    $parent = $($(link).data("parent-selector"))
    $new_el = $parent.append($new_html)
  else
    $parent = $(link).parent()
    $new_el = $parent.before($new_html)

  $func = $(link).data("do-after-add")
  if $func
    eval "$(link).#{$func}"

$ ->

  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  $.fn.bind_clearable_fields()
  $.fn.bind_filter_html_elements()
  $.fn.bind_button_urls()

  $("[data-counter='true']").bind_counter()

  $("[placeholder]").addClass("placeholder")

  $("[data-nicedit]").each ->
    new nicEditor().panelInstance($(this).attr("id"))

  $('[data-wysiwym]').each ->
    $(this).wysiwym(Wysiwym.Markdown)

  $('.datepicker').datepicker
    format: 'dd.mm.yyyy'
    weekStart: 1

  $("[data-checkboxes-clone]").each ->
    $(this).bind_checkboxes_clone()
  $("[data-collapsible-label]").each ->
    $(this).bind_collapsible_label()

  $("[data-boolean-value]").each ->
    $(this).bind_boolean_value()

  $("#flash_panel").delay(3000).fadeOut 3000

