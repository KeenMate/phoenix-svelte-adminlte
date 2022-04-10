defmodule PhoenixSvelteAdminlte.Tree do
  alias PhoenixSvelteAdminlte.Models.Node

  def get_init_tree() do
    [
      %Node{node_path: "1", title: "Strength", has_children: true},
      %Node{node_path: "1.1", title: "Abbadon"},
      %Node{node_path: "1.2", title: "Axe"},
      %Node{node_path: "1.3", title: "Mars"},
      %Node{node_path: "1.4", title: "Tusk"}	,
      %Node{ node_path: "2", has_children: true, title: "Agility" },
      %Node{ node_path: "2.1", title: " Juggernaut" },
      %Node{ node_path: "2.2", title: " Gyrocopter" },
      %Node{ node_path: "2.3", title: " Lone Druid" },
      %Node{ node_path: "2.4", title: " Sniper" },
      %Node{ node_path: "2.5", title: " Viper" },
      %Node{ node_path: "3", has_children: true, title: "Intelligence" },
      %Node{ node_path: "3.1", title: " Dazzle" },
      %Node{ node_path: "3.2", title: " Chen" },
      %Node{ node_path: "3.3", title: " Lion" },
      %Node{ node_path: "3.4", title: " Techies" },
      %Node{ node_path: "3.5", title: " Void Spirit" },
    ]
  end

end
