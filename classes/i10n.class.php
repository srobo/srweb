<?php

class i10n
{
	private $data;

	protected function __construct() { }

	public static function getInstance()
	{
		static $_instance = null;
		if ($_instance === null)
		{
			$_instance = new i10n();
		}
		return $_instance;
	}

	public function set($name, $value = null)
	{
		$this->data[$name] = $value == null ? $name : $value;
	}

	public function get($name, $default = null)
	{
		if (!isset($this->data[$name]))
		{
			$this->data[$name] = $default == null ? $name : $default;
		}
		return $this->data[$name];
	}

	public function __set__($name, $value)
	{
		return $this->set($name, $value);
	}

	public function __get__($name)
	{
		return $this->get($name);
	}
}

function _i10n_get($name, $default = null)
{
	return i10n::getInstance()->get($name, $default);
}
