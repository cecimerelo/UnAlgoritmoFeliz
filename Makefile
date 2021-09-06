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

diversity: check_dependencies
	@for n in $$(seq 1 15); do make rastrigin CONFIG_FILE=config_file_15 ; done

size:
	@for n in $$(seq 1 15); do make buche_rastrigin CONFIG_FILE=config_file_19 ; done
	@for n in $$(seq 1 15); do make ellipsoidal CONFIG_FILE=config_file_19 ; done
	@for n in $$(seq 1 15); do make linear_slope CONFIG_FILE=config_file_19 ; done
	@for n in $$(seq 1 15); do make sphere CONFIG_FILE=config_file_19 ; done
	
rastrigin:
	julia --project=. examples/rastrigin.jl $(CONFIG_FILE)

buche_rastrigin:
	julia --project=. examples/buche_rastrigin.jl $(CONFIG_FILE)

ellipsoidal:
	julia --project=. examples/ellipsoidal.jl $(CONFIG_FILE)

linear_slope:
	julia --project=. examples/linear_slope.jl $(CONFIG_FILE)

sphere:
	julia --project=. examples/sphere.jl $(CONFIG_FILE)


