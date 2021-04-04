using DataFrames


function read_data_file(file_path::String, Type=nothing)
    file_lines = Type[]

    open(file_path) do f
      while ! eof(f)
         s = readline(f)

         if Type == String
             push!(file_lines, s)
         else
             push!(file_lines, parse(Type ,s))
         end
      end
    end

    return file_lines
end
