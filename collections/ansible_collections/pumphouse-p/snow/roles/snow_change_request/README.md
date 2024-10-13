# README for `apps.snow_change_request`

## Description

An Ansible Role that manages change requests in ServiceNow.

## Requirements

* `servicenow.itsm`

## Role Variables

Available variables are described in the table below.

| Variable Name | Default | Required | Type | Description |
|:-------------:|:-------:|:--------:|:----:|:-----------:|
|     `var`     | `value` |    no    | str  | Desciption  |


## Dependencies

* ``

## Example Playbook

```yaml
---
- name: Play name
  hosts: localhost
  gather_facts: false
  become: false

  roles:
  - role: pumphouse_p.apps.snow_change_request
```

## License

GPL

## Author Information

Devin Parrish ([GitHub](https://github.com/pumphouse-p))