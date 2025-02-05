package WebFormsCore;

import java.util.List;
import java.util.ArrayList;

class NameValueCollection {
    private List<NameValue> nameValueList = new ArrayList<>();

    public void add(String name, String value) {
        nameValueList.add(new NameValue(name, value));
    }

    public void set(String name, String value) {
        if (!exist(name)) {
            add(name, value);
        } else {
            changeValue(name, value);
        }
    }

    public void delete(String name) {
        nameValueList.removeIf(nv -> nv.getName().equals(name));
    }

    public void deleteByIndex(int index) {
        int tmpIndex = (index >= 0) ? index : nameValueList.size() + index;
        nameValueList.remove(tmpIndex);
    }

    public void empty() {
        nameValueList.clear();
    }

    public boolean exist(String name) {
        return nameValueList.stream().anyMatch(nv -> nv.getName().equals(name));
    }

    public void changeValue(String name, String value) {
        for (NameValue nv : nameValueList) {
            if (nv.getName().equals(name)) {
                nv.setValue(value);
                break;
            }
        }
    }

    public void changeName(String name, String newName) {
        for (NameValue nv : nameValueList) {
            if (nv.getName().equals(name)) {
                nv.setName(newName);
                break;
            }
        }
    }

    // Overload
    public void changeValue(String name, String newName, String value) {
        for (NameValue nv : nameValueList) {
            if (nv.getName().equals(name)) {
                nv.setName(newName);
                nv.setValue(value);
                break;
            }
        }
    }

    public void changeValueByIndex(int index, String value) {
        int tmpIndex = (index >= 0) ? index : nameValueList.size() + index;
        nameValueList.get(tmpIndex).setValue(value);
    }

    public void changeNameByIndex(int index, String name) {
        int tmpIndex = (index >= 0) ? index : nameValueList.size() + index;
        nameValueList.get(tmpIndex).setName(name);
    }

    public void changeNameValueByIndex(int index, String name, String value) {
        int tmpIndex = (index >= 0) ? index : nameValueList.size() + index;
        NameValue nv = nameValueList.get(tmpIndex);
        nv.setName(name);
        nv.setValue(value);
    }

    public void addList(List<NameValue> nameValueList) {
        this.nameValueList.addAll(nameValueList);
    }

    public String getValue(String name) {
        for (NameValue nv : nameValueList) {
            if (nv.getName().equals(name)) {
                return nv.getValue();
            }
        }
        return "";
    }

    public String getNameByIndex(int index) {
        int tmpIndex = (index >= 0) ? index : nameValueList.size() + index;
        return nameValueList.get(tmpIndex).getName();
    }

    public String getValueByIndex(int index) {
        int tmpIndex = (index >= 0) ? index : nameValueList.size() + index;
        return nameValueList.get(tmpIndex).getValue();
    }

    public List<NameValue> getList() {
        return nameValueList;
    }
}