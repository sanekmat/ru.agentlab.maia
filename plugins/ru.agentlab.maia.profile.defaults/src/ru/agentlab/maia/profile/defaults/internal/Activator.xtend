package ru.agentlab.maia.profile.defaults.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.behaviour.scheme.lib.BehaviourSchemeOneShot
import ru.agentlab.maia.context.agent.AgentFactory
import ru.agentlab.maia.context.agent.MaiaAgentProfile
import ru.agentlab.maia.context.behaviour.BehaviourFactory
import ru.agentlab.maia.context.behaviour.MaiaBehaviourProfile
import ru.agentlab.maia.context.container.ContainerFactory
import ru.agentlab.maia.context.container.MaiaContainerProfile
import ru.agentlab.maia.context.initializer.IMaiaContextInitializerService
import ru.agentlab.maia.context.initializer.MaiaContextInitializerService
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.naming.uuid.UuidNameGenerator
import ru.agentlab.maia.context.root.MaiaRootContextProfile
import ru.agentlab.maia.execution.lifecycle.LifecycleService
import ru.agentlab.maia.execution.lifecycle.fipa.FipaLifecycleScheme
import ru.agentlab.maia.execution.pool.IMaiaExecutorPool
import ru.agentlab.maia.execution.pool.cached.MaiaCachedExecutorPool
import ru.agentlab.maia.execution.scheduler.scheme.SchemeScheduler
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleScheme
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleService
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.scheme.IMaiaExecutorSchedulerScheme
import ru.agentlab.maia.context.agent.IMaiaContextAgentFactory
import ru.agentlab.maia.context.container.IMaiaContextContainerFactory
import ru.agentlab.maia.context.behaviour.IMaiaContextBehaviourFactory

class Activator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	override start(BundleContext context) throws Exception {
		Activator.context = context

		val rootProfile = new MaiaRootContextProfile => [
			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IMaiaContextContainerFactory, ContainerFactory)
			putImplementation(IMaiaExecutorPool, MaiaCachedExecutorPool)
		]

		val containerProfile = new MaiaContainerProfile => [
			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IMaiaContextAgentFactory, AgentFactory)
			putImplementation(IMaiaContextLifecycleScheme, FipaLifecycleScheme)
			putImplementation(IMaiaContextLifecycleService, LifecycleService)
			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]

		val agentProfile = new MaiaAgentProfile => [
			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IMaiaContextBehaviourFactory, BehaviourFactory)
			putImplementation(IMaiaContextLifecycleScheme, FipaLifecycleScheme)
			putImplementation(IMaiaContextLifecycleService, LifecycleService)
			putImplementation(IMaiaExecutorScheduler, SequenceContextScheduler)
			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]

		val behaviourProfile = new MaiaBehaviourProfile => [
			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IMaiaContextLifecycleScheme, FipaLifecycleScheme)
			putImplementation(IMaiaContextLifecycleService, LifecycleService)
			putImplementation(IMaiaExecutorSchedulerScheme, BehaviourSchemeOneShot)
			putImplementation(IMaiaExecutorScheduler, SchemeScheduler)
			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]

		context => [
			registerService(MaiaRootContextProfile, rootProfile, null)
			registerService(MaiaContainerProfile, containerProfile, null)
			registerService(MaiaAgentProfile, agentProfile, null)
			registerService(MaiaBehaviourProfile, behaviourProfile, null)
		]
	}

	override stop(BundleContext context) throws Exception {
		Activator.context = null
	}

}
