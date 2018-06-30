//nota 7 siete
//test: falla 1, algunos detalle 
//1) B: hay código duplicado y problemas de nombres
//2) R: mal modelo: los pacientes no conocen su rutina (por eso falla el el último test)
//3) B+: algo de codigo duplicado 
//4) B+

class CentroDeKinesiologia{
	var aparatos = []
	var pacientes
	
	method coloresDeAparatos() = aparatos.map({aparato=>aparato.color()}).asSet()
	
	method pacientesMenoresDeOchoAnios() = pacientes.filter({paciente=> paciente.edad() < 8})
	
	//Esto está mal, porque aparatos es el conjunto de aparatos del centro, no la rutina que le correspodne al paciente
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
	
	//TODO: codigo duplicado con nopuedeUsarMinitrampPaciente de minitramp
	//debería ser un template method en aparato para evitar la duplicacion
	//TODO: mejorar nombre, esto es una validacion pero parece una pregunta
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
	
    //TODO: la rutina tiene que ser parte del modelo, si no el usuario del objeto
    //paciente tiene que saber de antemano cual es la rutina que debe realizar
    //para ese paciente. No quedó esa información en ningún objeto de tu modelo.
    //es un problema de responsabilidad importante!. Es la causa principal
    //de que no puedas hacer andar el último test, ya que cada paciente tiene una rutina 
    //especial, y vos en lugar de probar para cada paciente la rutina correspondiente,
    //le haces probar todos los aparatos en el orden que el centro los tiene guardado.
	method realizarSesion(unaSesion){
		    self.noPuedeRealizarSesion(unaSesion)
			unaSesion.forEach({aparato=>self.utilizarAparato(aparato) })
	}
	
	//TODO: problemas de nombres
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
		//TODO: repite código! debe llamar a super de nuevo!
		unaSesion.forEach({aparato=>self.utilizarAparato(aparato) })
		
		}
}

class PacienteDeRapidaRecuperacion inherits Paciente {
	override  method realizarSesion(unaSesion){
		super(unaSesi
			on
		)
		self.disminuirNivelDeDolor(decremntarNivelDeDolorParaPacienteDeRapidaRecuperacio.valorADecrementar())
	}
	
	
	
    
}


object decremntarNivelDeDolorParaPacienteDeRapidaRecuperacio {
	var property valorADecrementar
	
}






