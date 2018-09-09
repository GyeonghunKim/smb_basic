function tif_name = pma2tif(file_name)

    fid_pma = fopen(file_name,'r');
    file_info=dir(file_name);

    ysize=fread(fid_pma,1,'int16'); 
    xsize=fread(fid_pma,1,'int16');
    
    film_length=(file_info.bytes-4)/xsize/ysize;
    tif_name = strcat(file_name(1:end-4),'.tif');
    
    one_frame = fread(fid_pma,[ysize,xsize], 'uint8');
    imwrite(one_frame', tif_name);

for i=1:film_length-1
    if rem(i,100) == 0
        
        disp([num2str(i+1), '/', num2str(film_length)]);
    end
    one_frame = fread(fid_pma,[ysize,xsize], 'uint8');
    imwrite(one_frame', tif_name, 'WriteMode', 'append');  
end

end