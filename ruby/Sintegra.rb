require './spider'
require 'nokogiri'
require 'json'

class Sintegra < Spider

  # Método construtor
  def initialize()
    super('http://www.sintegra.es.gov.br')
  end

  # Método para buscar os dados
  def buscarDados(paramCNPJ)
    @PaginaEmHtml = self.post('/resultado.php', {
                        'num_cnpj' => paramCNPJ, 'num_ie' => '', 'botao' => 'Consultar'
                    })

        parsed_data = Nokogiri::HTML.parse(@PaginaEmHtml.body)
        info = parsed_data.xpath("//td[@class='valor']")
       

        dados = {:dados => {
                    :cnpj => info[0].lstrip,
                    :inscricao_estadual => info[1].text.lstrip,
                    :razao_social => info[2].text.lstrip,
                    :logradouro => info[3].text.lstrip,
                    :numero => info[4].text.lstrip,
                    :complemento => info[5].text.lstrip,
                    :bairro => info[6].text.lstrip,
                    :municipio => info[7].text.lstrip,
                    :uf => info[8].text.lstrip,
                    :cep => info[9].text.lstrip,
                    :telefone => info[10].text.lstrip,
                    :atividade_economica => info[11].text.lstrip,
                    :atividade_economica_data_inicio => info[12].text.lstrip,
                    :situacao_cadastral_vigente => info[13].text.lstrip,
                    :data_desta_situacao_cadastral => info[14].text.lstrip,
                    :regime_de_apuracao => info[15].text.lstrip,
                    :emitente_de_nf_desde => info[16].text.lstrip,
                    :obrigado_a_emitir_nota_em => info[17].text.lstrip    
                }
            }
        
        puts JSON.pretty_generate(dados)
        end
end
