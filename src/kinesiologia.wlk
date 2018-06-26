//completar el codigo!


class CentroDeKinesiologia{
	var aparatos = []
	var pacientes
	
	method coloresDeAparatos() = aparatos.map({aparato=>aparato.color()}).asSet()
	
	method pacientesMenoresDeOchoAnios() = pacientes.filter({paciente=> paciente.edad() < 8})
	
	method pacientesQueNoPuedenCumPlirSesion() = pacientes.count({paciente=> 
		!paciente.puedeRealizarSesion(aparatos)
	})
	
	method agregarAparato(unAparato){ aparatos.add(unAparato)}
	
	}

class Aparato {
	var property color 
	
	method recibirPaciente(unPaciente)
	
	method puedeUsarAparatoPaciente(unPaciente)
	
	method cantidadDeDolorQueDisminuyeAunPaciente(unPaciente)
	
}

class Magneto inherits Aparato {
	
	override method cantidadDeDolorQueDisminuyeAunPaciente(unPaciente) = unPaciente.nivelDeDolor() * 0.1
	
	override method recibirPaciente(unPaciente){
		unPaciente.disminuirNivelDeDolor(self.cantidadDeDolorQueDisminuyeAunPaciente(unPaciente))
	}
	override method puedeUsarAparatoPaciente(unPaciente) = true
	
}

class Bicicleta  inherits Aparato{
	
	override method cantidadDeDolorQueDisminuyeAunPaciente(unPaciente) = 4
	
	method noPuedeUsarBiciletaPaciente(unPaciente){
		if(!self.puedeUsarAparatoPaciente(unPaciente)){
			self.error("el paciente no es mayor de 8 anios")
		}
	}
	
	override method puedeUsarAparatoPaciente(unPaciente)  = unPaciente.edad() > 8
	

	
	override method recibirPaciente(unPaciente){
		self.noPuedeUsarBiciletaPaciente(unPaciente)
		unPaciente.disminuirNivelDeDolor(self.cantidadDeDolorQueDisminuyeAunPaciente(unPaciente))
		unPaciente.aumentarFortalezaMuscular(3)
	}	
}

class Minitramp inherits Aparato {
	
	override method cantidadDeDolorQueDisminuyeAunPaciente(unPaciente) = unPaciente.edad() * 0.1
	
	
	override method puedeUsarAparatoPaciente(paciente) = paciente.nivelDeDolor() < 20 
	
	method nopuedeUsarMinitrampPaciente(paciente){
		if(!self.puedeUsarAparatoPaciente(paciente)){
			self.error("no puede usar el aparato el paciente que no tiene un dolor inferior a 20")
		}
	}
	
	override method recibirPaciente(unPaciente){
		self.nopuedeUsarMinitrampPaciente(unPaciente)
		unPaciente.aumentarFortalezaMuscular(self.cantidadDeDolorQueDisminuyeAunPaciente(unPaciente))
	}
}



class Paciente {
	var property edad
	var nivelDeFortalezaMuscular
	var nivelDeDolor
	
	method nivelDeFortalezaMuscular() = nivelDeFortalezaMuscular
	
	method nivelDeDolor() = nivelDeDolor
	
	method disminuirNivelDeDolor(unCantidad){nivelDeDolor-=unCantidad }
	
	method aumentarFortalezaMuscular(unCantidad) {nivelDeFortalezaMuscular+= unCantidad}
	
	method utilizarAparato(aparato){aparato.recibirPaciente(self)}
	
    
	method realizarSesion(unaSesion){
		    self.noPuedeRealizarSesion(unaSesion)
			unaSesion.forEach({aparato=>self.utilizarAparato(aparato) })
	}
	
	method noPuedeRealizarSesion(unaSesion){
		if(!self.puedeRealizarSesion(unaSesion)){
			self.error("no puede realizar la sesion")
		}
	}
	
	method puedeRealizarSesion(unaSecion) = unaSecion.all
	({aparato=>aparato.puedeUsarAparatoPaciente(self)})
	
}

class PacienteResistente inherits Paciente {
	
	override method realizarSesion(unaSesion){
		super(unaSesion)
		self.aumentarFortalezaMuscular(unaSesion.size())
	}
	
}

class PacienteCaprichoso inherits Paciente {
	
	method alMenosUnAparatoEsDeColorRojo(unSesion) = unSesion.any({aparato=>
		aparato.color() == "rojo"})
	
	override method puedeRealizarSesion(unaSesion) = super(unaSesion) and
	self.alMenosUnAparatoEsDeColorRojo(unaSesion)
	
	override method realizarSesion(unaSesion) {
		super(unaSesion)
		unaSesion.forEach({aparato=>self.utilizarAparato(aparato) })
		
		}
}

class PacienteDeRapidaRecuperacion inherits Paciente {
	override  method realizarSesion(unaSesion){
		super(unaSesion)
		self.disminuirNivelDeDolor(decremntarNivelDeDolorParaPacienteDeRapidaRecuperacio.valorADecrementar())
	}
	
	
	
    
}


object decremntarNivelDeDolorParaPacienteDeRapidaRecuperacio {
	var property valorADecrementar
	
}






