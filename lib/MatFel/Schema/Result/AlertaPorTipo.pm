package MatFel::Schema::Result::AlertaPorTipo;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

  # For the time being this is necessary even for virtual views
  __PACKAGE__->table('AlertaPorTipo');

  #
  # ->add_columns, etc.
  #

  # do not attempt to deploy() this view
  __PACKAGE__->result_source_instance->is_virtual(1);

  __PACKAGE__->result_source_instance->view_definition(q[
    SELECT sig_id.sig_id as signature_id, sig_id.sig_priority as signature_priority, sig_id.sig_name as signature_name, 
    COUNT( * ) AS cuentaEinar FROM alerta JOIN event evento ON 
    ( evento.cid = alerta.cid AND evento.sid = alerta.sid )  JOIN signature sig_id ON sig_id.sig_id = evento.signature 
    WHERE ( ( evento.timestamp >= ? AND alerta.id_servidor = ? ) ) 
    GROUP BY evento.signature ORDER BY cuentaEinar DESC
  ]);
  
   __PACKAGE__->add_columns(
    'signature_id' => {
      data_type => 'integer',
    },
    'signature_priority' => {
      data_type => 'integer',
    },
    'cuentaEinar' => {
      data_type => 'integer',
    },
    
    'signature_name' => {
      data_type => 'varchar',
      size      => 100,
    },
  );
  
  
  1;
