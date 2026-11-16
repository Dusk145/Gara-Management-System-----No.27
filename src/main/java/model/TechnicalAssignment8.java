package model;

public class TechnicalAssignment8 {
    private int id;
    private TechnicalStaff8 ts;

    public TechnicalAssignment8() {}
    public TechnicalAssignment8(int id, TechnicalStaff8 ts) {
        this.id = id;
        this.ts = ts;
    }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public TechnicalStaff8 getTs() { return ts; }
    public void setTs(TechnicalStaff8 ts) { this.ts = ts; }
}