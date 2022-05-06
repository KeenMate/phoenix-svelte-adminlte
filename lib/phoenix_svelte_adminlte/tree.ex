defmodule PhoenixSvelteAdminlte.Tree do
  alias PhoenixSvelteAdminlte.Models.Node

  def get_init_tree() do
    [
      %Node{
        node_path: "4",
        title: "My team",
        has_children: true,
        priority: 0,
        is_draggable: false,
        insert_disabled: true,
        nest_disabled: true
      },
      %Node{
        node_path: "4.1",
        title: "First game",
        has_children: true,
        priority: 0,
        is_draggable: false,
        insert_disabled: true
      },
      %Node{
        node_path: "4.2",
        title: "Second game",
        has_children: true,
        priority: 1,
        is_draggable: false,
        insert_disabled: true
      },
      %Node{
        node_path: "4.3",
        title: "Third game",
        has_children: true,
        priority: 2,
        is_draggable: false,
        insert_disabled: true
      },
      %Node{
        node_path: "1",
        title: "Strength",
        has_children: true,
        is_draggable: false,
        insert_disabled: true,
        type: "1"
      },
      %Node{node_path: "1.1", title: "Abbadon", nest_disabled: true,type: "1"},
      %Node{node_path: "1.2", title: "Axe", nest_disabled: true,type: "1"},
      %Node{node_path: "1.3", title: "Mars", nest_disabled: true,type: "1"},
      %Node{node_path: "1.4", title: "Tusk", nest_disabled: true,type: "1"},
      %Node{
        node_path: "2",
        title: "Agility",
        has_children: true,
        is_draggable: false,
        insert_disabled: true,
        type: "2"
      },
      %Node{node_path: "2.1", title: " Juggernaut", nest_disabled: true,type: "2"},
      %Node{node_path: "2.2", title: " Gyrocopter", nest_disabled: true,type: "2"},
      %Node{node_path: "2.3", title: " Lone Druid", nest_disabled: true,type: "2"},
      %Node{node_path: "2.4", title: " Sniper", nest_disabled: true,type: "2"},
      %Node{node_path: "2.5", title: " Viper", nest_disabled: true,type: "2"},
      %Node{
        node_path: "3",
        title: "Intelligence",
        has_children: true,
        is_draggable: false,
        insert_disabled: true,
        type: "3"
      },
      %Node{node_path: "3.1", title: " Dazzle", nest_disabled: true,type: "3"},
      %Node{node_path: "3.2", title: " Chen", nest_disabled: true,type: "3"},
      %Node{node_path: "3.3", title: " Lion", nest_disabled: true,type: "3"},
      %Node{node_path: "3.4", title: " Techies", nest_disabled: true,type: "3"},
      %Node{node_path: "3.5", title: " Void Spirit", nest_disabled: true,type: "3"}
    ]
  end
end
