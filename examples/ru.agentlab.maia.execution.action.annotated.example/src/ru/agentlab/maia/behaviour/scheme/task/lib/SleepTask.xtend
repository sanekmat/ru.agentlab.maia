package ru.agentlab.maia.behaviour.scheme.task.lib

import javax.inject.Inject
import ru.agentlab.maia.execution.action.annotated.Action
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

class SleepTask {

	@Inject
	IMaiaExecutorScheduler scheduler

	@Inject
	IMaiaExecutorScheduler behaviour

	@Action
	def void action() {
//		scheduler.block(behaviour)
	}

}