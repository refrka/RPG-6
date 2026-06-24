extends Node


var services:= {}




func register_service(service: Variant) -> void:

	print(service.get_script())

	services[service.get_script()] = service





func request_service(service_name: Script) -> Variant:

	if services.has(service_name):

		return services[service_name]

	return null