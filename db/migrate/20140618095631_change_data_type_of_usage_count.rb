class ChangeDataTypeOfUsageCount < ActiveRecord::Migration
  def change
	rename_column :invite_codes, :consumed, :usage
	change_column :invite_codes, :usage,  :integer
  end
end
