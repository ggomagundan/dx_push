json.status  @json_result.status
json.msg @json_result.msg

if @json_result.object.present?

  json.device @json_result.object

end

