all: check_dependencies tests

check_dependencies: Project.toml requirements.jl
	julia --project=Project.toml requirements.jl  --target=Project.toml

tests: check_dependencies
	julia --project=. src/run_tests.jl

all_examples: check_dependencies
	julia --project=. examples/sphere.jl $(CONFIG_FILE)
	julia --project=. examples/ellipsoidal.jl $(CONFIG_FILE)
	julia --project=. examples/rastrigin.jl $(CONFIG_FILE)
	julia --project=. examples/buche_rastrigin.jl $(CONFIG_FILE)
	julia --project=. examples/linear_slope.jl $(CONFIG_FILE)