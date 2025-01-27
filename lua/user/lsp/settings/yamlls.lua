local yc_ok, yc = pcall(require, "yaml-companion")
if not yc_ok then
	--[[ Return basic config if no yaml-companion ]]

	local opts = {
		settings = {
			yaml = {
				hover = true,
				completion = true,
				validate = true,
				schemaStore = {
					enable = true,
					url = "https://www.schemastore.org/api/json/catalog.json",
				},
				schemas = {
					kubernetes = {
						"daemon.{yml,yaml}",
						"manager.{yml,yaml}",
						"restapi.{yml,yaml}",
						"role.{yml,yaml}",
						"role_binding.{yml,yaml}",
						"*onfigma*.{yml,yaml}",
						"*ngres*.{yml,yaml}",
						"*ecre*.{yml,yaml}",
						"*eployment*.{yml,yaml}",
						"*ervic*.{yml,yaml}",
						"kubectl-edit*.yaml",
					},
				},
			},
		},
	}

	return opts
end

local opts = yc.setup({

	-- Built in file matchers
	builtin_matchers = {
		-- Detects Kubernetes files based on content
		kubernetes = { enabled = true },
	},

	-- Additional schemas available in Telescope picker
	-- schemas = {
	-- 	result = {
	-- 		--{
	-- 		--  name = "Kubernetes 1.22.4",
	-- 		--  uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
	-- 		--},
	-- 	},
	-- },
	schemas = {
		kubernetes = "*.yaml",
		["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
		["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
		["http://json.schemastore.org/ansible-stable-2.9"] = "ansible/tasks/*.{yml,yaml}",
		["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
		["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
		["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
		["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
		["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
		["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
		["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
		["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
		["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
		["https://json.schemastore.org/taskfile.json"] = "Taskfile*.yml",
	},
	-- Pass any additional options that will be merged in the final LSP config
	lspconfig = {
		flags = {
			debounce_text_changes = 150,
		},
		settings = {
			redhat = { telemetry = { enabled = false } },
			yaml = {
				validate = true,
				format = { enable = true },
				hover = true,
				completion = true,
				schemaStore = {
					enable = true,
					url = "https://www.schemastore.org/api/json/catalog.json",
				},
				schemaDownload = { enable = true },
				schemas = {},
				trace = { server = "debug" },
			},
		},
	},
})

--[[ Enable Telescope ]]
local tel_ok, telescope = pcall(require, "telescope")
if tel_ok then
	telescope.load_extension("yaml_schema")
end

-- [[ Return finished opts ]]
return opts
