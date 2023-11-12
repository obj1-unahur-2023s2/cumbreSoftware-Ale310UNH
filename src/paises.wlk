class Pais {
	const paisesConConflicto = #{}
	
	
	method registrarConflictoCon(unPais) {
		paisesConConflicto.add(unPais)
	}
	
	method estaEnConfilctoCon(unPais) = paisesConConflicto.contains(unPais)
}