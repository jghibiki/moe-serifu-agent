###################################################
# Recipes auto-generated by gendeps.py script.    #
# These recipes should not be edited by hand; any #
# changes will be overwritten.                    #
###################################################

$(ODIR)/agent/agent.o: $(SDIR)/agent/agent.cpp $(SDIR)/agent/agent.hpp $(SDIR)/msa.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util/string.hpp $(SDIR)/agent/hooks.hpp $(SDIR)/log/log.hpp $(SDIR)/log/hooks.hpp $(SDIR)/output/output.hpp $(SDIR)/output/hooks.hpp $(SDIR)/util/var.hpp
	$(CXX) -c -o $@ $(SDIR)/agent/agent.cpp $(CXXFLAGS)

$(ODIR)/util/util.o: $(SDIR)/util/util.cpp $(SDIR)/util/util.hpp
	$(CXX) -c -o $@ $(SDIR)/util/util.cpp $(CXXFLAGS)

$(ODIR)/msa.o: $(SDIR)/msa.cpp $(SDIR)/msa.hpp $(SDIR)/agent/agent.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util/string.hpp $(SDIR)/agent/hooks.hpp $(SDIR)/input/input.hpp $(SDIR)/input/hooks.hpp $(SDIR)/cmd/cmd.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/cmd/hooks.hpp $(SDIR)/event/dispatch.hpp $(SDIR)/event/timer.hpp $(SDIR)/event/timer_hooks.hpp $(SDIR)/event/hooks.hpp $(SDIR)/log/log.hpp $(SDIR)/log/hooks.hpp $(SDIR)/output/output.hpp $(SDIR)/output/hooks.hpp $(SDIR)/plugin/plugin.hpp $(SDIR)/plugin/hooks.hpp
	$(CXX) -c -o $@ $(SDIR)/msa.cpp $(CXXFLAGS)

$(ODIR)/event/event.o: $(SDIR)/event/event.cpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp
	$(CXX) -c -o $@ $(SDIR)/event/event.cpp $(CXXFLAGS)

$(ODIR)/event/handler.o: $(SDIR)/event/handler.cpp $(SDIR)/event/handler.hpp $(SDIR)/msa.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp
	$(CXX) -c -o $@ $(SDIR)/event/handler.cpp $(CXXFLAGS)

$(ODIR)/event/dispatch.o: $(SDIR)/event/dispatch.cpp $(SDIR)/event/dispatch.hpp $(SDIR)/msa.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/event/timer.hpp $(SDIR)/cmd/cmd.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util/string.hpp $(SDIR)/cmd/hooks.hpp $(SDIR)/event/timer_hooks.hpp $(SDIR)/event/hooks.hpp $(SDIR)/util/util.hpp $(SDIR)/log/log.hpp $(SDIR)/log/hooks.hpp $(SDIR)/agent/agent.hpp $(SDIR)/agent/hooks.hpp
	$(CXX) -c -o $@ $(SDIR)/event/dispatch.cpp $(CXXFLAGS)

$(ODIR)/event/timer.o: $(SDIR)/event/timer.cpp $(SDIR)/event/timer.hpp $(SDIR)/msa.hpp $(SDIR)/cmd/cmd.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util/string.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/cmd/hooks.hpp $(SDIR)/event/timer_hooks.hpp $(SDIR)/event/dispatch.hpp $(SDIR)/event/hooks.hpp $(SDIR)/log/log.hpp $(SDIR)/log/hooks.hpp $(SDIR)/agent/agent.hpp $(SDIR)/agent/hooks.hpp
	$(CXX) -c -o $@ $(SDIR)/event/timer.cpp $(CXXFLAGS)

$(ODIR)/input/input.o: $(SDIR)/input/input.cpp $(SDIR)/input/input.hpp $(SDIR)/msa.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util/string.hpp $(SDIR)/input/hooks.hpp $(SDIR)/event/dispatch.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/event/timer.hpp $(SDIR)/cmd/cmd.hpp $(SDIR)/cmd/hooks.hpp $(SDIR)/event/timer_hooks.hpp $(SDIR)/event/hooks.hpp $(SDIR)/util/util.hpp $(SDIR)/log/log.hpp $(SDIR)/log/hooks.hpp
	$(CXX) -c -o $@ $(SDIR)/input/input.cpp $(CXXFLAGS)

$(ODIR)/util/string.o: $(SDIR)/util/string.cpp $(SDIR)/util/string.hpp
	$(CXX) -c -o $@ $(SDIR)/util/string.cpp $(CXXFLAGS)

$(ODIR)/cfg/cfg.o: $(SDIR)/cfg/cfg.cpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util/string.hpp
	$(CXX) -c -o $@ $(SDIR)/cfg/cfg.cpp $(CXXFLAGS)

$(ODIR)/cmd/cmd.o: $(SDIR)/cmd/cmd.cpp $(SDIR)/cmd/cmd.hpp $(SDIR)/msa.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util/string.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/cmd/hooks.hpp $(SDIR)/event/dispatch.hpp $(SDIR)/event/timer.hpp $(SDIR)/event/timer_hooks.hpp $(SDIR)/event/hooks.hpp $(SDIR)/agent/agent.hpp $(SDIR)/agent/hooks.hpp $(SDIR)/log/log.hpp $(SDIR)/log/hooks.hpp
	$(CXX) -c -o $@ $(SDIR)/cmd/cmd.cpp $(CXXFLAGS)

$(ODIR)/log/log.o: $(SDIR)/log/log.cpp $(SDIR)/log/log.hpp $(SDIR)/msa.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util/string.hpp $(SDIR)/log/hooks.hpp $(SDIR)/util/util.hpp
	$(CXX) -c -o $@ $(SDIR)/log/log.cpp $(CXXFLAGS)

$(ODIR)/output/output.o: $(SDIR)/output/output.cpp $(SDIR)/output/output.hpp $(SDIR)/msa.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util/string.hpp $(SDIR)/output/hooks.hpp $(SDIR)/log/log.hpp $(SDIR)/log/hooks.hpp
	$(CXX) -c -o $@ $(SDIR)/output/output.cpp $(CXXFLAGS)

$(ODIR)/util/var.o: $(SDIR)/util/var.cpp $(SDIR)/util/var.hpp
	$(CXX) -c -o $@ $(SDIR)/util/var.cpp $(CXXFLAGS)

$(ODIR)/plugin/plugin.o: $(SDIR)/plugin/plugin.cpp $(SDIR)/plugin/plugin.hpp $(SDIR)/msa.hpp $(SDIR)/cmd/cmd.hpp $(SDIR)/cfg/cfg.hpp $(SDIR)/util/string.hpp $(SDIR)/event/handler.hpp $(SDIR)/event/event.hpp $(SDIR)/event/topics.hpp $(SDIR)/cmd/hooks.hpp $(SDIR)/plugin/hooks.hpp $(SDIR)/log/log.hpp $(SDIR)/log/hooks.hpp $(SDIR)/agent/agent.hpp $(SDIR)/agent/hooks.hpp
	$(CXX) -c -o $@ $(SDIR)/plugin/plugin.cpp $(CXXFLAGS)

