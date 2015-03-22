package ru.agentlab.maia.launcher

import javax.inject.Inject
import javax.inject.Named
import ru.agentlab.maia.Action
import ru.agentlab.maia.ActionTicker
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.agent.IAgent

class BehaviourExample {
	
	@Inject 
	@Named(IBehaviour.KEY_NAME)
	String behName
	
	@Inject 
	@Named(IAgent.KEY_NAME)
	String agentName

	@Action(type=IBehaviour.TYPE_TICKER)
	@ActionTicker(period=500, fixedPeriod=false)
	def void action() {
		println('''«agentName»::«behName» - «System.currentTimeMillis»''')
	}

}