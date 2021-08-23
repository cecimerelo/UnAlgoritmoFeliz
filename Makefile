tests:
	julia src/run_tests.jl

install_dependencies:
	julia requirements.jl

base_example:
	julia examples/base.jl