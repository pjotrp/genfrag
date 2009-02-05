
module Genfrag
class App

class Command

  attr_accessor :options  # a Hash used by optparse
  attr_accessor :ops      # an OpenStruct of the options

  def initialize( out = STDOUT, err = STDERR )
    @out = out
    @err = err
    @options = {
    #  :skeleton_dir => File.join(mrbones_dir, 'data'),
    #  :with_tasks => false,
    #  :verbose => false,
    #  :name => nil,
    #  :output_dir => nil
    }
    #@options[:skeleton_dir] = ::Bones.path('data') unless test(?d, skeleton_dir)
  end

  def cli_run( args )
    raise NotImplementedError
  end
  
  def run( args )
    raise NotImplementedError
  end

# Create a unique filename for the frequency file out of a combination of filenames
#
  def name_freq_lookup(input_filenames=[])
    if @ops.filelookup
      # FIXME used to be gsub! - make sure it still works in code
      return @ops.filelookup.gsub(/\.(db|tdf)$/, '')
    elsif !input_filenames.empty?
      if @ops.re5 and @ops.re3
        [input_filenames.sort,@ops.re5.downcase,@ops.re3.downcase,'index'].join('_').gsub(/\//,'x')
      else
        raise "re5 or re3 is undefined"
      end
    else
      raise "--lookup undefined and no default filenames passed"
    end
  end

# Create a unique filename out of a combination of filenames
#
  def name_normalized_fasta(input_filenames=[])
    if @ops.filefasta
      # FIXME used to be gsub! - make sure it still works in code
      return @ops.filefasta.gsub(/\.(db|tdf)$/, '')
    elsif !input_filenames.empty?
      return [input_filenames.sort, 'normalized'].join('_').gsub(/\//,'x')
    else
      raise "--fasta undefined and no default filenames passed"
    end
  end

# Return the name of the adapters file without its extension
#
  def name_adapters
    return nil if !@ops.fileadapters
    return @ops.fileadapters.gsub(/\.(db|tdf)$/, '')
  end

# Print running output when used in command-line mode
#
  def cli_p(cli=true, str='')
    return false if !cli or @ops.quiet
    @out.puts str
  end

# Define the command-line option available
#
  def standard_options
    {
      :verbose => ['-v', '--verbose', 'enable verbose output',
          lambda {
            options[:verbose] = true
          }],
      :tracktime => ['-m', '--tracktime', 'track execution time',
          lambda {
            options[:tracktime] = true
          }],
      :quiet => ['-q', '--quiet', 'silence output',
          lambda {
            options[:quiet] = true
          }],
      :re5 => ['-5', '--re5 ENZYME', String, "5' restriction enzyme",
          lambda { |value|
            options[:re5] = value
          }],
      :re3 => ['-3', '--re3 ENZYME', String, "3' restriction enzyme",
          lambda { |value|
            options[:re3] = value
          }],
      :sqlite => ['-t', '--sqlite', 'use sqlite', '(default is CSV)',
          lambda {
            options[:sqlite] = true
          }],
      :filelookup => ['-l', '--lookup FILE', String, "name of the frequency lookup file generated by 'index'",
          lambda { |value|
            options[:filelookup] = value
          }],
      :filefasta => ['-f', '--fasta FILE', String, 'name of the Fasta sequences file',
          lambda { |value|
            options[:filefasta] = value
          }],
      :size => ['-s', '--size SIZE', Array, '',
          lambda { |value|
            options[:size] = value
          }],
          
      :adapter5 => ['-y', '--adapter5 ADAPTER', String, '',
          lambda { |value|
            options[:adapter5] = value
          }],
      :adapter3 => ['-z', '--adapter3 ADAPTER', String, '',
          lambda { |value|
            options[:adapter3] = value
          }],
          
      :named_adapter5 => ['-b', '--named-adapter5 NAME', String, '',
          lambda { |value|
            options[:named_adapter5] = value
          }],
      :named_adapter3 => ['-c', '--named-adapter3 NAME', String, '',
          lambda { |value|
            options[:named_adapter3] = value
          }],
          
      :adapter5_size => ['-d', '--adapter5-size SIZE', Integer, '',
          lambda { |value|
            options[:adapter5_size] = value
          }],
      :adapter3_size => ['-e', '--adapter3-size SIZE', Integer, '',
          lambda { |value|
            options[:adapter3_size] = value
          }],
          
      :adapter5_sequence => ['-i', '--adapter5-sequence SEQUENCE', String, '',
          lambda { |value|
            options[:adapter5_sequence] = value
          }],
      :adapter3_sequence => ['-j', '--adapter3-sequence SEQUENCE', String, '',
          lambda { |value|
            options[:adapter3_sequence] = value
          }],
          
      :fileadapters => ['-a', '--adapters FILE', String, '',
          lambda { |value|
            options[:fileadapters] = value
          }]

    }
  end

end  # class Command
end  # class App
end  # module Genfrag

# EOF
