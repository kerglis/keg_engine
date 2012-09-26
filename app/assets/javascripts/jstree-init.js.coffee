$.fn.bind_jstree = ->
  $theme = $(this).data("jstree-theme") || "apple"
  $auth_token = $(this).data("jstree-auth-token")
  $initial_data = $(this).data("jstree-initial-data")

  $img_root = $(this).data("jstree-img-root") || "/assets/icons/blue-folder-share.png"
  $img_doc  = $(this).data("jstree-img-doc")  || "/assets/icons/blue-document-text.png"

  $tree_base_url = $(this).data("jstree-base-url")
  $get_children_url = $(this).data("jstree-get-children-url")
  $move_node_url = $(this).data("jstree-move-node-url")
  $change_state_url = $(this).data("jstree-change-state-url")

  $txt_create = $(this).data("jstree-txt-create") || "Create new"
  $txt_delete = $(this).data("jstree-txt-delete") || "Delete"
  $txt_confirm_delete = $(this).data("jstree-txt-confirm-delete") || "Really delete?"
  $txt_rename = $(this).data("jstree-txt-rename") || "Rename"
  $txt_edit = $(this).data("jstree-txt-edit") || "Edit"

  $(this).jstree
    plugins: ["themes", "contextmenu", "json_data", "crrm", "dnd", "ui", "types", "cookies" ] # "unique", "hotkeys",
    themes:
      theme: $theme
    ui:
      select_limit: 1

    types:
      valid_children: ["root"]
      types:
        root:
          icon:
            image: $img_root
          valid_children: ["default"]
          max_depth: 3
          hover_node: false
          select_node: ->
            false

        default:
          valid_children: ["default"]
          icon:
            image: $img_doc

    json_data:
      data: $initial_data
      ajax:
        url: (n) ->
          $tree_base_url + "/" + n.attr("id") + $get_children_url

    contextmenu:
      items: (node) ->
        items =
          ccp: false
          create:
            label: $txt_create
            action: (obj) ->
              @create obj

          rename:
            label: $txt_rename
            action: (obj) ->
              @rename obj

          remove:
            label: $txt_delete
            action: (obj) ->
              @remove obj

          edit:
            label: $txt_edit
            action: (obj) ->
              id = obj.attr("id")
              edit_url = $tree_base_url + "/" + id + "/edit"
              window.location = edit_url

        if $(node).attr("rel") is "root"
          items.rename._disabled = true
          items.remove._disabled = true
        items

  $(this).bind "create.jstree", (e, data) ->
    name = data.rslt.name
    node = data.rslt.obj
    parent_id = $(data.rslt.parent).attr("id")
    $.ajax
      type: "POST"
      url: $tree_base_url + ".json"
      data:
        "taxon[name]": name
        "taxon[parent_id]": parent_id
        authenticity_token: $auth_token
      success: (jdata) ->
        $(node).attr "id", jdata.attr.id

  $(this).bind "rename.jstree", (e, data) ->
    new_name = data.rslt.new_name
    update_url = $tree_base_url + "/" + $(data.rslt.obj).attr("id") + ".json"
    $.ajax
      type: "POST"
      url: update_url
      data:
        _method: "put"
        "taxon[name]": new_name
        authenticity_token: $auth_token

  $(this).bind "remove.jstree", (e, data) ->
    remove_url = $tree_base_url + "/" + $(data.rslt.obj).attr("id") + ".json"
    $.ajax
      type: "DELETE"
      url: remove_url
      authenticity_token: $auth_token

  $(this).bind "move_node.jstree", (e, data) ->
    original_id = data.rslt.o.attr("id")
    receiver_id = data.rslt.r.attr("id")
    pos = data.rslt.p
    move_url = $tree_base_url + $move_node_url
    $.ajax
      type: "POST"
      url: move_url
      data:
        original_id: original_id
        receiver_id: receiver_id
        positioning: pos
        authenticity_token: $auth_token

  $(this).bind "change_state.jstree", (e, data) ->
    id = data.rslt.attr("id")
    change_state_url = $tree_base_url + "/" + id + $change_state_url
    $.ajax
      type: "POST"
      url: change_state_url
      data:
        id: id
        authenticity_token: $auth_token

  $(this).bind "before.jstree", (e, data) ->
    if data.func is "remove" and not confirm($txt_confirm_delete)
      e.stopImmediatePropagation()
      false

$ ->
  $(".jstree").each ->
    $(this).bind_jstree()
