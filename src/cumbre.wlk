import paises.*
import conocimientos.*

object cumbre {
	const paisesAuspiciantes = #{}
	const participantesRegistradosParaEntrar = #{}
	const participantes = #{}
	var property cantidadDeCommitsNecesariosParaIngresar = 300
	const registroDeActs = []
	
	method agregarPersonaAlRegistroParaEntrar(unaPersona) {
		participantesRegistradosParaEntrar.add(unaPersona)
	}
	
	method esConflictivo(unPais) = paisesAuspiciantes.any({p => p.estaEnConfilctoCon(unPais)})
	
	method agregarPaisesAuspiciantes(paises) {
		paisesAuspiciantes.addAll(paises)
	}
	
	method ingresarPersona(unaPersona) {
		if(self.puedeIngresar(unaPersona)) {
			participantes.add(unaPersona)
		}
		else {
			self.error("La persona no cumple con las condiciones para ingresar")
		}
	}
	
	method puedeIngresar(unaPersona) = unaPersona.cumpleCondicionesDeIngresoA(self) and not self.tieneRestingidoElAcceso(unaPersona) and self.cumpleSegundaCondicion(unaPersona)
	
	method cumpleSegundaCondicion(unaPersona) {return
		if(paisesAuspiciantes.contains(unaPersona.pais())) 
			true
		
		else 
		    not self.paisesDeLosParticipantes().contains(unaPersona.pais())
	}
	
	method tieneRestingidoElAcceso(unaPersona) = paisesAuspiciantes.any({p => unaPersona.esDePaisConflictivoCon(p)})
	
	method paisesDeLosParticipantes() = participantes.map({p => p.pais()}).asSet()
	
	method cantidaDeParticipantesDe(unPais) = participantes.filter({p => p.pais() == unPais}).size()
	
	method paisConMasParticipantes() = self.paisesDeLosParticipantes().max({p => self.cantidaDeParticipantesDe(p)})
	
	method participantesExtranjeros() = participantes.filter({p => not paisesAuspiciantes.contains(p.pais())})
	
	method esRelevante() = participantes.all({p => p.esCape()})
	
	method esSegura() = participantesRegistradosParaEntrar.all({p => self.puedeIngresar(p)})
	
	method realizarActividad(unaAct) {
		participantes.forEach({p => p.hacerActividad(unaAct)})
		self.registrarUnaAct(unaAct)
	}
	
	method registrarUnaAct(act) {
		registroDeActs.add(act)
	}
	
	method totalDeHorasDeActsRealizadas() = registroDeActs.map({a => a.horas()}).sum()
}