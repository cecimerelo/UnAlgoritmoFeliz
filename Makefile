tests:
	julia src/run_tests.jl

install_dependencies:
	julia requirements.jl

base_example:
	make install_dependencies
	julia examples/base.jl