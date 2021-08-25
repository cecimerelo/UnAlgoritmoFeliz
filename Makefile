check_dependencies: Project.toml
	julia --project=Project.toml requirements.jl  --target=Project.toml

tests: 
	make check_dependencies
	julia --project=. src/run_tests.jl

base_example:
	make check_dependencies
	julia --project=. examples/base.jl