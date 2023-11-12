import conocimientos.*
import cumbre.*
import actividades.*

class Participante {
	const property pais
	const property conocimientos = #{}
	var comitsHechos
	
	method comitsHechos() = comitsHechos
	
	method esCape()
	
	method cantidadDeConocimientos() = conocimientos.size()
	
	method cumpleCondicionesDeIngresoA(unaCumbre) = conocimientos.contains(programacionBasica)
	
	method agregarConocimiento(unConocimiento) {
		conocimientos.add(unConocimiento)
	}
	
	method agregarCommits(cantidad) {
		comitsHechos += cantidad
	}
	
	method esDePaisConflictivoCon(unPais) = pais.estaEnConfilctoCon(unPais)
	
	method hacerActividad(unaActividad) {
		self.agregarConocimiento(unaActividad.tema())
		self.agregarCommits(unaActividad.tema().commitsPorHora() * unaActividad.horas())
	}
}

class Programador inherits Participante {
	var horasDeCapacitacion = 0
	
	override method esCape() = comitsHechos > 500
	
	override method cumpleCondicionesDeIngresoA(unaCumbre) = super(unaCumbre) and comitsHechos > unaCumbre.cantidadDeCommitsNecesariosParaIngresar()
	
	override method hacerActividad(unaActividad) {
		super(unaActividad)
		horasDeCapacitacion += unaActividad.horas()
	}
}

class Especialista inherits Participante {
	
	override method esCape() = self.cantidadDeConocimientos() > 2
	
	override method cumpleCondicionesDeIngresoA(unaCumbre) = super(unaCumbre) and comitsHechos > (unaCumbre.cantidadDeCommitsNecesariosParaIngresar() - 100) and conocimientos.contains(objetos)
}

class Gerente inherits Participante {
	var empresaQueTrabaja
	
	override method esCape() = empresaQueTrabaja.esMultinacional()
	
	override method cumpleCondicionesDeIngresoA(unaCumbre) = super(unaCumbre) and conocimientos.contains(manejoDeGrupos)
}

