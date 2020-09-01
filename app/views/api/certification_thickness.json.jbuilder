if @block.blank?
  json.found  false
else
  json.found  true
  json.mean_thickness     @block.mean_thickness
  json.min_thickness      @block.min_thickness
  json.max_thickness      @block.max_thickness
  json.std_dev_thickness  @block.std_dev_thickness
  json.mean_alloy         @block.mean_alloy
  json.min_alloy          @block.min_alloy
  json.max_alloy          @block.max_alloy
  json.std_dev_alloy      @block.std_dev_alloy
  json.readings @block.readings.each do |reading|
    json.timestamp  reading.reading_at
    json.thickness  reading.thickness
    json.alloy      reading.alloy
  end
end